using System.ComponentModel.DataAnnotations.Schema;

namespace BarberFlow.API.Models;

public class UserModel
{
    [Column("id_user")]
    public int Id { get; set; }

    [Column("nome")]
    public required string Name { get; set; }

    [Column("telefone")]
    public string? Celphone { get; set; }

    public string Email { get; set; } = null!;

    [Column("senhahash")]
    public required string PasswordHash { get; set; }

    [Column("roles")]
    public string? Role { get; set; }
}

//# users (id, nome, cpf, telefone, email, senha)
//# create table users (
//# id_user INT auto_increment PRIMARY KEY,
//# nome VARCHAR(100) NOT NULL,
//# telefone VARCHAR(11) NOT NULL,
//# email VARCHAR(100) NOT NULL,
//# senha VARCHAR(25) NOT NULL
//#)
