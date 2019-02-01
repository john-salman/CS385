def main():
    aperf = open("aperf.R")
    mperf = open("mperf.R")

    # get on line "label tsc"
    line_a = aperf.readline()
    line_m = mperf.readline()

    # move off "label tsc"
    line_a = aperf.readline()
    line_m = mperf.readline()
    
    starts_m = []
    stops_m = []

    starts_a = []
    stops_a = []

    alternate = 0
    while line_a:

        if (not alternate):
            starts_a.append(float(line_a[7:]))
            alternate = 1
        else:
            stops_a.append(float(line_a[6:]))
            alternate = 0
        line_a = aperf.readline()

    # alternate should be 0
    while line_m:
        if (not alternate):
            starts_m.append(float(line_m[7:]))
            alternate = 1
        else:
            stops_m.append(float(line_m[6:]))
            alternate = 0
        line_m = mperf.readline()

    sum_start_a = 0        
    for start_a in starts_a:
        sum_start_a += start_a

    sum_stop_a = 0
    for stop_a in stops_a:
        sum_stop_a += stop_a

    sum_start_m = 0
    for start_m in starts_m:
        sum_start_m += start_m

    sum_stop_m = 0
    for stop_m in stops_m:
        sum_stop_m += stop_m

    delta_m = sum_stop_m - sum_start_m 
    delta_a = sum_stop_a - sum_start_a
    print delta_m
    print delta_a
    print delta_m / delta_a 
    eff_clock_freq = delta_m / delta_a

    print "Effective clock frequency: ", eff_clock_freq

main()
            
    
