
/** A class to hold the values from Scheduling output.
 * 
 * @author Chris */
public class Run {
    public String processIntesity;
    public String runTimeBound;
    public String scheduler;
    public double wallTime;
    public double kernelTime;
    public double userTime;
    public double cpuUsage;
    public double involContextSwitch;
    public double volContextSwitch;

    /** @param processIntesity
     * @param runTimeBound
     * @param scheduler
     * @param wallTime
     * @param kernelTime
     * @param userTime
     * @param cpuUsage
     * @param involContextSwitch
     * @param volContextSwitch */
    public Run(String processIntesity, String runTimeBound, String scheduler, double wallTime,
            double kernelTime, double userTime, double cpuUsage, double involContextSwitch,
            double volContextSwitch) {
        super();
        this.processIntesity = processIntesity;
        this.runTimeBound = runTimeBound;
        this.scheduler = scheduler;
        this.wallTime = wallTime;
        this.kernelTime = kernelTime;
        this.userTime = userTime;
        this.cpuUsage = cpuUsage;
        this.involContextSwitch = involContextSwitch;
        this.volContextSwitch = volContextSwitch;
    }

}
