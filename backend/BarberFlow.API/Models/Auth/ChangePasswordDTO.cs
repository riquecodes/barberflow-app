namespace BarberFlow.API.Models.Auth;

public class ChangePasswordDTO
{
    public required string CurrentPassword { get; set; }
    public required string NewPassword { get; set; }
}
