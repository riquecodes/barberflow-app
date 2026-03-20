namespace BarberFlow.Application.AuthItems.Helpers;

public class Helpers(IUserRepository userRepository)
{
    private readonly IUserRepository _userRepository = userRepository;

    public static async Task ValidateUserCredentials(string email, string password)
    {
        var user = await _userRepository.GetUserByEmailAsync(email);

        if (user)
    }
}
