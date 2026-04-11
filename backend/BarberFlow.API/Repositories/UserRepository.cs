using Microsoft.EntityFrameworkCore;
using BarberFlow.API.Context;
using BarberFlow.API.Models;

namespace BarberFlow.API.Repositories;

public class UserRepository(AppDbContext context) : IUserRepository
{
    private readonly AppDbContext _context = context;

    public async Task<IEnumerable<UserResponseDTO>> GetUsers()
    {
        var users = await _context.Users.ToListAsync();

        return users.Select(u => new UserResponseDTO
        {
            UserId = u.Id,
            Name = u.Name,
            Celphone = u.Celphone,
            Email = u.Email,
            Role = u.Role
        });
    }

    public async Task<UserResponseDTO?> GetUserById(int id)
    {
        var user = await _context.Users.FindAsync(id);

        if (user is null)
            return null;

        return new UserResponseDTO
        {
            UserId = user.Id,
            Name = user.Name,
            Celphone = user.Celphone,
            Email = user.Email,
            Role = user.Role
        };
    }

    public async Task<UserResponseDTO?> GetUserByEmail(string email)
    {
        var user = await _context.Users.FirstOrDefaultAsync(u => u.Email == email);

        if (user is null)
            return null;

        return new UserResponseDTO
        {
            UserId = user.Id,
            Name = user.Name,
            Celphone = user.Celphone,
            Email = user.Email,
            Role = user.Role
        };
    }

    public async Task<UserModel?> GetFullUserById(int id)
    {
        var user = await _context.Users.FirstOrDefaultAsync(u => u.Id == id);

        if (user is null)
            return null;

        return user;
    }

    public async Task<UserModel?> GetFullUserByEmail(string email)
    {
        var user = await _context.Users.FirstOrDefaultAsync(u => u.Email == email);

        if (user is null)
            return null;

        return user;
    }

    public async Task<UserModel> CreateUser(UserModel user)
    {
        await _context.Users.AddAsync(user);
        await _context.SaveChangesAsync();
        return user;
    }

    public async Task<UserModel?> UpdateUser(int id, UserModel user)
    {
        var updatedUser = await GetFullUserById(id);

        if (updatedUser is null)
            return null;

        updatedUser.Name = user.Name;
        updatedUser.Celphone = user.Celphone;
        updatedUser.Email = user.Email;
        updatedUser.Role = user.Role;

        await _context.SaveChangesAsync();
        return updatedUser;
    }

    public async Task<bool> DeleteUserById(int id)
    { 
        var userToDelete = await GetFullUserById(id);
        
        if (userToDelete is null)
            return false;

        _context.Users.Remove(userToDelete);
        await _context.SaveChangesAsync();

        return true;
    }
}
