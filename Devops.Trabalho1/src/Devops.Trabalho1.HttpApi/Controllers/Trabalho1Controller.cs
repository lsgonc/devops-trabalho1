using Devops.Trabalho1.Localization;
using Volo.Abp.AspNetCore.Mvc;

namespace Devops.Trabalho1.Controllers;

/* Inherit your controllers from this class.
 */
public abstract class Trabalho1Controller : AbpControllerBase
{
    protected Trabalho1Controller()
    {
        LocalizationResource = typeof(Trabalho1Resource);
    }
}
