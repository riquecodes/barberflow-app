using System.ComponentModel.DataAnnotations.Schema;

namespace BarberFlow.API.Models;

public class AppointmentModel
{
    public int Id { get; set; }

    [Column("id_usuario")]
    public int UserId { get; set; }

    [Column("id_servico")]
    public int ServiceId { get; set; }

    [Column("data")]
    public DateOnly Date { get; set; }

    [Column("hora")]
    public TimeOnly Time { get; set; }

    [Column("cancelado")]
    public bool IsCanceled { get; set; } = false;

    public UserModel User { get; set; } = null!;
    public ServiceModel Service { get; set; } = null!;
}
