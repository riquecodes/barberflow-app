using System.ComponentModel.DataAnnotations.Schema;

namespace BarberFlow.API.Models;

public class TimeSlotModel
{
    public int Id { get; set; }

    [Column("hora")]
    public TimeOnly Time { get; set; } // Ex: 09:00, 09:30
}
