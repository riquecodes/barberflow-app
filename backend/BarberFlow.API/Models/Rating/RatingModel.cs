using System.ComponentModel.DataAnnotations.Schema;

namespace BarberFlow.API.Models.Rating;

public class RatingModel
{
    [Column("id_avaliacao")]
    public int Id { get; set; }

    [Column("estrelas")]
    public int Stars { get; set; }

    [Column("comentario")]
    public string? Comment { get; set; }

    [Column("id_user")]
    public int UserId { get; set; }

    [Column("id_servico")]
    public int? ServiceId { get; set; }
}
