using System.ComponentModel.DataAnnotations.Schema;

namespace BarberFlow.API.Models;

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


//# avaliacoes(id, estrelas, comentario, id_usuario, id_servico)
//# create table avaliacoes(
//# id_avaliacao INT auto_increment PRIMARY KEY,
//# estrelas INT NOT NULL,
//# comentario VARCHAR(200),
//# id_user INT NOT NULL,
//# id_servico INT NOT NULL,
//#    
//# FOREIGN KEY (id_user) references users(id_user),
//# FOREIGN KEY (id_servico) references services(id_service)
//#)
