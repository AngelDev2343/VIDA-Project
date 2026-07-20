# Widgets iOS (VIDA)

El código de los widgets ya está en `ios/VidaWidgets/`:

- `ContraPecadoWidget` — frase diaria
- `FavoritoWidget` — versículo favorito

Ambos leen datos del App Group `group.com.vida.project` (mismo ID que usa Flutter con `HomeWidget.setAppGroupId`).

## Activar el target en Xcode (una vez)

Los archivos Swift están listos, pero Xcode debe registrar la extensión:

1. Abre `ios/Runner.xcworkspace` en Xcode.
2. **File → New → Target… → Widget Extension**.
3. Product Name: `VidaWidgets`, Language: Swift, desactiva “Include Configuration Intent”.
4. Cuando pregunte, activa el App Group `group.com.vida.project` en **Runner** y en **VidaWidgets** (Signing & Capabilities → App Groups).
5. Sustituye el código generado por los archivos de `ios/VidaWidgets/` (o apunta el target a esa carpeta).
6. En **Runner** → Signing & Capabilities, asegúrate de que `Runner.entitlements` incluye el App Group.
7. Build & run en un iPhone/simulador; luego mantén pulsada la pantalla de inicio → **Editar** → **Agregar widget** → VIDA.

Bundle IDs sugeridos:

- App: `com.vida.project`
- Extension: `com.vida.project.VidaWidgets`

Flutter ya llama `HomeWidget.updateWidget(iOSName: 'ContraPecadoWidget' | 'FavoritoWidget')` desde la app.
