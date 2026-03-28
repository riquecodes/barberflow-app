namespace BarberFlow.API.Models;

public class UserModel
{
    public int Id { get; set; }
    public required string Name { get; set; }
    public string? Celphone { get; set; }
    public string Email { get; set; } = null!;
    public required string PasswordHash { get; set; }
    public string Role { get; set; } = "client";
}

//# users (id, nome, cpf, telefone, email, senha)
//# create table users (
//# id_user INT auto_increment PRIMARY KEY,
//# nome VARCHAR(100) NOT NULL,
//# telefone VARCHAR(11) NOT NULL,
//# email VARCHAR(100) NOT NULL,
//# senha VARCHAR(25) NOT NULL
//#)
