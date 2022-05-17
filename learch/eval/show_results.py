import os
import argparse
from termcolor import colored
from tabulate import tabulate
from mycov import get_cov, total
import collections

def get_args():
    parser = argparse.ArgumentParser()
    parser.add_argument('--prog_list', dest='prog_list', type=str, required=True)
    parser.add_argument('--cov_dir', dest='cov_dir', type=str, required=True)
    args = parser.parse_args()
    return args

args = get_args()

colors = ['red', 'green', 'yellow', 'magenta', 'cyan', 'white']

def format_cov(cov, times):
    return round(cov * 1000) / (1000 / times)

def main():
    progs = []
    with open(args.prog_list) as f:
        for line in f:
            progs.append(line.strip().split('##')[0])
    progs = list(sorted(progs))
    searchers = list(sorted(os.listdir(args.cov_dir)))
    
    cov_table = [[] for i in range(len(progs)+3)]
    cov_nums = [[0 for i in range(len(searchers))] for j in range(len(progs))]
    cov_change = [[{} for i in range(len(searchers))] for j in range(len(progs))]

    for j, searcher in enumerate(searchers):
        line_cov_total, ubsan_total = 0, 0
        for i, prog in enumerate(progs):
            color = colors[i % len(colors)]
            if j == 0:
                cov_table[i].append(colored(prog, color))

            path = os.path.join(args.cov_dir, searcher, prog)
            line_cov = len(get_cov(os.path.join(path,'root')))
            ubsan = 0
            line_cov_10mins = {}
            for f in os.listdir(path):
                if os.path.isdir(os.path.join(path, f)):
                    # print(f)
                    if (f != 'root'):
                        line_cov_10mins[int(f)] = len(get_cov(os.path.join(path,f)))
                if f.endswith('overflow.err') or f.endswith('soob.err') or f.endswith('oob.err') or f.endswith('po.err') or f.endswith('nd.err'):
                    ubsan += 1
            #print("Line coverage changes: ")
            line_cov_10mins = collections.OrderedDict(sorted(line_cov_10mins.items()))
            #for point, line_coverage in line_cov_10mins.items(): print(point, line_coverage)
            line_cov_total += line_cov
            ubsan_total += ubsan
            cov_table[i].append(colored(f'{line_cov} {ubsan}', color))
            cov_nums[i][j] = line_cov
            cov_change[i][j] = line_cov_10mins

        line_cov_avg = line_cov_total / len(progs)
        if j == 0:
            cov_table[len(progs)].append('line_cov_avg')
            cov_table[len(progs)+1].append('ubsan_total')
            cov_table[len(progs)+2].append('best_cov')
        cov_table[len(progs)].append(f'{format_cov(line_cov_avg, 1)}')
        cov_table[len(progs)+1].append(f'{ubsan_total}')
        cov_table[len(progs)+2].append(0)

    for i in range(len(progs)):
        best_cov = -1
        for j in range(len(searchers)):
            if cov_nums[i][j] > best_cov:
                best_cov = cov_nums[i][j]
        for j in range(len(searchers)):
            if cov_nums[i][j] == best_cov:
                cov_table[len(progs)+2][j+1] += 1
    print(len(cov_table))
    print(len(searchers))
    print(len(cov_table[0]))
    for j in range(len(searchers)):
        cov_table[len(progs)+2][j+1] = str(cov_table[len(progs)+2][j+1])

    print(tabulate(cov_table, headers=['']+searchers, tablefmt='orgtbl'))
    
    print("Line Coverage Change")
    for i in range(len(progs)):
        for j in range(len(searchers)):
            print(progs[i],'And',searchers[j])
            for point, line_coverage in cov_change[i][j].items(): print(point, line_coverage)
if __name__ == '__main__':
    main()
