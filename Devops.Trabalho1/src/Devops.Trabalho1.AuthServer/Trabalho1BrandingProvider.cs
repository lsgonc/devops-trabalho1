using Microsoft.Extensions.Localization;
using Devops.Trabalho1.Localization;
using Volo.Abp.DependencyInjection;
using Volo.Abp.Ui.Branding;

namespace Devops.Trabalho1;

[Dependency(ReplaceServices = true)]
public class Trabalho1BrandingProvider : DefaultBrandingProvider
{
    private IStringLocalizer<Trabalho1Resource> _localizer;

    public Trabalho1BrandingProvider(IStringLocalizer<Trabalho1Resource> localizer)
    {
        _localizer = localizer;
    }

    public override string AppName => _localizer["AppName"];
}
