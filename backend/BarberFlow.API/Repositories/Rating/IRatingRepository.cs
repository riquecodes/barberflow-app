using BarberFlow.API.Models.Rating;

namespace BarberFlow.API.Repositories.Rating;

public interface IRatingRepository
{
    Task<IEnumerable<RatingModel>> GetRatingsAsync();

    Task<RatingModel?> GetRatingByIdAsync(int id);

    Task<RatingModel> CreateAsync(RatingModel rating);

    Task<bool> DeleteAsync(int id);
}
