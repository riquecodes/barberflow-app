namespace BarberFlow.API.Models.User;

public class UserModelDTO
{
    public required string Name { get; set; }
    public string? Celphone { get; set; }
    public string Email { get; set; } = null!;
    public string Role { get; set; } = "client";
}
