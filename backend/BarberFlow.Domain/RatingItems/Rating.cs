namespace BarberFlow.Domain.RatingItems;

public class Rating
{
    public int RatingId { get; set; }

    public int UserId { get; set; }

    public int ServiceId { get; set; }

    public int Stars { get; set; }

    public string? Comment { get; set; }
}
