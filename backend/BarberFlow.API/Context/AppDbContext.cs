using Microsoft.EntityFrameworkCore;
using BarberFlow.API.Models.User;
using BarberFlow.API.Models.Appointment;
using BarberFlow.API.Models.Service;
using BarberFlow.API.Models.Rating;

namespace BarberFlow.API.Context
{
    public class AppDbContext : DbContext
    {
        public AppDbContext(DbContextOptions<AppDbContext> options)
            : base(options) { }

        public DbSet<TimeSlotModel> TimeSlots { get; set; }
        public DbSet<AppointmentModel> Appointments { get; set; }
        public DbSet<UserModel> Users { get; set; }
        public DbSet<ServiceModel> Services { get; set; }
        public DbSet<RatingModel> Ratings { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            modelBuilder.Entity<AppointmentModel>()
                .HasIndex(a => new { a.Date, a.Time })
                .IsUnique();
        }
    }
}
