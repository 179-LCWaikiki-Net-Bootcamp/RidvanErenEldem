using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Models;
using Repositories.Interfaces;
using Response;
using Services.Interfaces;

namespace Services
{
    public class DirectorSerivce : IDirectorService
    {
        private readonly IDirectorRepository directorRepository;
        private readonly IUnitOfWork unitOfWork;

        public DirectorSerivce(IDirectorRepository directorRepository, IUnitOfWork unitOfWork)
        {
            this.directorRepository = directorRepository;
            this.unitOfWork = unitOfWork;
        }
        public async Task<DirectorResponse> SaveAsync(Director director)
        {
            try
            {
                await directorRepository.Insert(director);
                await unitOfWork.CompleteAsync();

                return new DirectorResponse(director);
            }
            catch (Exception ex)
            {
                return new DirectorResponse($"An error occurred when saving the director: {ex.Message}");
            }
        }

        public async Task<List<Director>> GetAllAsync()
        {
            return await directorRepository.GetAllAsync();
        }
    }
}