namespace BarberFlow.API.Models.Appointment;

public class AdminAppointmentDTO
{
    public int Id { get; set; }
    public string UserName { get; set; } = "";
    public string ServiceName { get; set; } = "";
    public DateOnly Date { get; set; }
    public TimeOnly Time { get; set; }
    public decimal ServicePrice { get; set; }
    public bool IsCanceled { get; set; }
}
