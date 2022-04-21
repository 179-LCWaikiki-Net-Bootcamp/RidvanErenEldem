using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using AutoMapper;
using Models;
using Resources;

namespace Mapping
{
    public class ModelToResourceProfile : Profile
    {
        public ModelToResourceProfile()
        {
            CreateMap<Director, DirectorResource>(MemberList.None);
            CreateMap<SaveDirectorResource, Director>(MemberList.None);
        }
    }
}