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

        public async Task<DirectorResponse> UpdateAsync(int id, Director director)
        {
            var existing = await directorRepository.GetByIdAsync(id);

            if(existing == null)
                return new DirectorResponse("Director Not Found");
            
            existing.Name =  director.Name;
            existing.Birthday = director.Birthday;
            
            try
            {
                directorRepository.Update(existing);
                await unitOfWork.CompleteAsync();

                return new DirectorResponse(existing);
            }
            catch (Exception ex)
            {
                return new DirectorResponse($"An error occurred while updating director: {ex.Message}");
            }
        }
    }
}