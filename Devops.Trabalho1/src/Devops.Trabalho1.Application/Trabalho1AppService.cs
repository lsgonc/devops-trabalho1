using Devops.Trabalho1.Localization;
using Volo.Abp.Application.Services;

namespace Devops.Trabalho1;

/* Inherit your application services from this class.
 */
public abstract class Trabalho1AppService : ApplicationService
{
    protected Trabalho1AppService()
    {
        LocalizationResource = typeof(Trabalho1Resource);
    }
}
