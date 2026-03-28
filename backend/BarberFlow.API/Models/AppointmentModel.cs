namespace BarberFlow.API.Models;

public class AppointmentModel
{
    public int Id { get; set; }

    public int UserId { get; set; }
    public int ServiceId { get; set; }

    public DateTime Date { get; set; }
    public TimeSpan Time { get; set; }

    public bool IsCanceled { get; set; } = false;

    public UserModel User { get; set; } = null!;
    public ServiceModel Service { get; set; } = null!;
}
