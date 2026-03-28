namespace BarberFlow.API.Models;

public class UserModelDTO
{
    public required string Name { get; set; }
    public string? Celphone { get; set; }
    public string? Email { get; set; }
    public string Role { get; set; } = "client";
}
