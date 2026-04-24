using System.ComponentModel.DataAnnotations.Schema;

namespace BarberFlow.API.Models.Service;

public class ServiceModel
{
    [Column("id_service")]
    public int Id { get; set; }

    [Column("nome")]
    public string? Name { get; set; }

    [Column("valor")]
    public decimal Price { get; set; }

    [Column("descricao")]
    public string? Description { get; set; }

    [Column("duracao")]
    public int Duration { get; set; }
}

//# services(id, nome, valor, descricao, duracao)
//# create table services (
//# id_service INT auto_increment PRIMARY KEY,
//# nome VARCHAR(100) NOT NULL,
//# valor DECIMAL(10,2) NOT NULL,
//# descricao VARCHAR(100) NOT NULL,
//# duracao INT NOT NULL
//#)
