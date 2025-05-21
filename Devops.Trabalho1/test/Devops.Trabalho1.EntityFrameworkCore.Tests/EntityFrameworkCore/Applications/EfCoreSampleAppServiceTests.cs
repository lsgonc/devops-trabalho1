using Devops.Trabalho1.Samples;
using Xunit;

namespace Devops.Trabalho1.EntityFrameworkCore.Applications;

[Collection(Trabalho1TestConsts.CollectionDefinitionName)]
public class EfCoreSampleAppServiceTests : SampleAppServiceTests<Trabalho1EntityFrameworkCoreTestModule>
{

}
