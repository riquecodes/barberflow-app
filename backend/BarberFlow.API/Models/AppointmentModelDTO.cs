namespace BarberFlow.API.Models;

public class AppointmentModelDTO
{
    public DateOnly Date { get; set; }

    public TimeOnly Time { get; set; }
    
    public string? ServiceName { get; set; }

    public decimal ServicePrice { get; set; }
}
