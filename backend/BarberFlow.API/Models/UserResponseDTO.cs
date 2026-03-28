namespace BarberFlow.API.Models;

public class UserResponseDTO
{
    public int UserId { get; set; }
    public required string Name { get; set; }
    public string? Celphone { get; set; }
    public string? Email { get; set; }
    public string? Role { get; set; }

    public AuthResponseDTO? Auth { get; set; }
}
