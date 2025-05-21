using Devops.Trabalho1.Samples;
using Xunit;

namespace Devops.Trabalho1.EntityFrameworkCore.Domains;

[Collection(Trabalho1TestConsts.CollectionDefinitionName)]
public class EfCoreSampleDomainTests : SampleDomainTests<Trabalho1EntityFrameworkCoreTestModule>
{

}
