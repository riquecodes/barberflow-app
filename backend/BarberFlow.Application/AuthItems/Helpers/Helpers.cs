using BarberFlow.Application.ResponseItems;
using BarberFlow.Domain.UserItems;

namespace BarberFlow.Application.AuthItems.Helpers;

public class Helpers(IUserRepository userRepository)
{
    private readonly IUserRepository _userRepository = userRepository;

    public async Task<BaseResponse<User>> ValidateUserCredentials(string email, string password)
    {
        var user = await _userRepository.GetCompleteUserByEmailAsync(email);

        if (user is null)
            return BaseResponse<User>
                .ErrorResponse(404, "Usuário não encontrado.");

        if (user.Password != password)
            return BaseResponse<User>
                .ErrorResponse(409, "Usuário ou Senha incorretas.");

        return BaseResponse<User>
            .SuccessResponse(user);
    }
}
