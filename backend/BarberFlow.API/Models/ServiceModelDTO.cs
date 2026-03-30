using System.ComponentModel.DataAnnotations.Schema;

namespace BarberFlow.API.Models;

public class ServiceModelDTO
{
    [Column("nome")]
    public string? Name { get; set; }

    [Column("valor")]
    public decimal Price { get; set; }

    [Column("descricao")]
    public string? Description { get; set; }

    [Column("duracao")]
    public int Duration { get; set; }
}
