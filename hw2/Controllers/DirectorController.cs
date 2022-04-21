using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Models;
using Repositories.Interfaces;

namespace Controllers
{
    [Route("api/[controller]")]
    public class DirectorController : Controller
    {
        private readonly IRepository<Director> director;
        public DirectorController(IRepository<Director> director)
        {
            this.director = director;
        }

        [HttpGet]
        public async Task<List<Director>> GetAll()
        {
            return await director.GetAllAsync();
        }
        
    }
}