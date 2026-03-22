namespace BarberFlow.Domain.TimesItems;

public class Times
{
    public int TimeId { get; set; }

    public int UserId { get; set; }

    public int ServiceId { get; set; }

    public DateOnly Date { get; set; }

    public TimeOnly Time { get; set; }

    //public TimeOnly StartTime { get; set; }
    //public TimeOnly EndTime { get; set; }
    //public bool IsAvailable { get; set; }
}
