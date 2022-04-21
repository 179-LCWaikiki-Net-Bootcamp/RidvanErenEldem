using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using AutoMapper;
using Extensions;
using Microsoft.AspNetCore.Mvc;
using Models;
using Repositories.Interfaces;
using Resources;
using Services.Interfaces;

namespace Controllers
{
    [Route("api/[controller]")]
    public class DirectorController : Controller
    {
        private readonly IDirectorService directorService;
        private readonly IMapper mapper;
        public DirectorController(IDirectorService directorService, IMapper mapper)
        {
            this.directorService = directorService;
            this.mapper = mapper;
        }

        [HttpGet]
        public async Task<List<Director>> GetAll()
        {
            return await directorService.GetAllAsync();
        }
        
        /*[HttpPost]
        public async Task<IActionResult> AddAsync([FromBody] SaveDirectorResource resource)
        {
            if(!ModelState.IsValid)
                return BadRequest(ModelState.GetErrorMessages());
            var addedDirector = mapper.Map<SaveDirectorResource, Director>(resource);
            var result = await 
        }*/
        
    }
}