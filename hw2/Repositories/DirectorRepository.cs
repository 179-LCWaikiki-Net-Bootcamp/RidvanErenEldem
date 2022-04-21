using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Contexts;
using Models;
using Repositories.Interfaces;
using Response;

namespace Repositories
{
    public class DirectorRepository : Repository<Director>, IDirectorRepository
    {
        public DirectorRepository(AppDbContext context) : base(context)
        {
        }

    }
}