def trimline(line, maxlen=124):
    """string -> string[]

    Recursively shorten string if it is longer than maxlen. Return list of shortened lines

    If a line cannot be shortened an exception will be thrown.

    Default maxlen comes from the max line length in the original english helpx.txt:

        for f in \#\#current\ patch\ files/EN_orig/SMACX/*; do
            echo -e "$(LC_ALL=latin1 awk '{print length($0)}' < "$f" |sort -n|tail -n1)\t$f";
        done | sort -n

    """

    if len(line) <= maxlen:
        return [line]

    # Find the first space before maxlen and replace with \r\n
    splitpt = line.rindex(' ', 0, maxlen)
    before = line[:splitpt] + '\n'
    after = line[splitpt+1:]
    tmp = [before]
    tmp.extend(trimline(after, maxlen))
    return tmp

def main():
    import sys
    filename = sys.argv[1]

    with open(filename, encoding="latin1") as f:
        lines = f.readlines()

    newlines = []
    for line in lines:
        newlines.extend(trimline(line))

    with open(filename, "w", encoding="latin1", newline="\r\n") as f:
        f.writelines(newlines)

main()
