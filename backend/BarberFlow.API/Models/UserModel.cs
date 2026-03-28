namespace BarberFlow.API.Models;

public class UserModel
{
    public int Id { get; set; }
    public required string Name { get; set; }
    public string? Celphone { get; set; }
    public string? Email { get; set; }
    public required byte[] PasswordHash { get; set; }
    public string Role { get; set; } = "client";
}
