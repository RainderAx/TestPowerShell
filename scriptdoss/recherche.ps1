Add-Type -AssemblyName PresentationFramework

[xml]$xaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        Title="Fenêtre Personnalisée" Height="300" Width="400" WindowStyle="None" AllowsTransparency="True" Background="Transparent">
    <Grid>
        <Border Background="LightBlue" CornerRadius="20" BorderBrush="Blue" BorderThickness="2">
            <StackPanel Margin="20">
                <TextBlock Text="Bonjour, voici une fenêtre personnalisée!" Margin="10" FontSize="16"/>
                <Button Content="Fermer" Width="100" Margin="10" HorizontalAlignment="Center" Click="Close_Click"/>
            </StackPanel>
        </Border>
    </Grid>
</Window>
"@

$reader = (New-Object System.Xml.XmlNodeReader $xaml)
$window = [Windows.Markup.XamlReader]::Load($reader)

$window.FindName("Close_Click").Add_Click({
    $window.Close()
})

$window.ShowDialog()
