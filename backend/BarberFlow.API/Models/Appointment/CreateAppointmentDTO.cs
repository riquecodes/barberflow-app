namespace BarberFlow.API.Models.Appointment;

public class CreateAppointmentDTO
{
    public int UserId { get; set; }
    public int ServiceId { get; set; }
    public DateOnly Date { get; set; }
    public TimeOnly Time { get; set; }
}
