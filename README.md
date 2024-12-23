# Subir o ambiente Flutter

Para subir o ambiente flutter, instale o [Visual Studio Code](https://code.visualstudio.com/) para o rodar o flutter e utilizar no desenvolvimento

## Instalar o Flutter 
- Com o vscode aberto vai na aba estenções e pesquise por `Flutter`
- Após a instalação pressione `Ctrl+Shift+P` e escreva `Flutter` e selecione o `New Project`
- Como é a primeira vez ele vai pedir pra você instalar o Flutter SDK
### Para rodar o projeto
````bash
# Clone o repositório
git clone https://github.com/Dallacqua90125/Command_app.git
cd command_flutter
flutter run
````
### Rodar projeto com emulador
1. Instale o Android Studio
   - Baixe e instale a versão lady bug do [android studio](https://developer.android.com/studio?hl=pt-br)
2. Criar emulador
   - No android acesse no canto os tres pontos ⁝  e acesse o Virtual Device Menager
   - Crie um emulador `Pixel 5` e escolha uma imagem `Android API 29 ou API 33` e que seja igual o maior a Android 12
3. Rodar emulador com flutter
   - No VScode e com o emulador criado abra um terminal e rode os seguitnes comando:
````bash
# Para listar os emuladores
flutter emulators

# Para rodar um emulador
flutter emulators --launch <emulator id>

# Listar dispositivos
flutter devices

# Após rodar o emulador pode rodar o projeto
flutter run
````

## Documentação pra instalar o [SDK do Flutter](https://docs.flutter.dev/get-started/install/windows/mobile)(Se precisar)

