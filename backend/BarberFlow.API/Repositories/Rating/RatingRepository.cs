using BarberFlow.API.Context;
using BarberFlow.API.Models.Rating;
using Microsoft.EntityFrameworkCore;

namespace BarberFlow.API.Repositories.Rating;

public class RatingRepository(AppDbContext context) : IRatingRepository
{
    private readonly AppDbContext _context = context;

    public async Task<IEnumerable<RatingModel>> GetRatingsAsync()
        => await _context.Ratings.ToListAsync();

    public async Task<RatingModel?> GetRatingByIdAsync(int id)
        => await _context.Ratings.FindAsync(id);

    public async Task<RatingModel> CreateAsync(RatingModel rating)
    {
        _context.Ratings.Add(rating);
        await _context.SaveChangesAsync();
        return rating;
    }

    public async Task<bool> DeleteAsync(int id)
    {
        var rating = await _context.Ratings.FindAsync(id);
        if (rating is not null)
        {
            _context.Ratings.Remove(rating);
            await _context.SaveChangesAsync();

            return true;
        }

        return false;
    }
}
