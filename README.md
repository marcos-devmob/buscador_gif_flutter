# Buscador de GIFs

Aplicativo mobile desenvolvido em **Flutter** que consome a **API do Giphy**, permitindo pesquisar, visualizar e compartilhar GIFs animados.  
O app utiliza arquitetura simples, integração HTTP e gerenciamento de estado interno para atualizar a interface dinamicamente.

---

## 🚀 Funcionalidades

- 🔎 Pesquisa de GIFs por palavra-chave  
- 🔥 Exibição dos GIFs em alta (trending)  
- ➕ Paginação com carregamento incremental (“Carregar mais...”)  
- 📤 Compartilhamento de GIFs via link com o **Share Plus**  
- 🖼️ Efeitos de fade suave no carregamento das imagens  
- 🎨 Interface escura e responsiva  

---

## 🧠 Tecnologias utilizadas

- **Flutter** (SDK mais recente)
- **Dart**
- **HTTP** – consumo da [API do Giphy](https://developers.giphy.com/)
- **Share Plus** – compartilhamento nativo via link  
- **Transparent Image** – placeholder leve para imagens em carregamento  

---

## 📁 Estrutura do Projeto

```
lib/
├── main.dart                # Ponto de entrada do app
└── ui/
    ├── home_page.dart       # Página principal com busca e listagem
    └── gif_page.dart        # Página de exibição e compartilhamento de GIF
```

---

## 🧩 Como executar o projeto

1. **Clone este repositório:**
   ```bash
   git clone https://github.com/marcos-devmob/buscador_gif_flutter.git
   ```
2. **Acesse a pasta do projeto:**
   ```bash
   cd buscador_gif_flutter
   ```
3. **Instale as dependências:**
   ```bash
   flutter pub get
   ```
4. **Execute o app:**
   ```bash
   flutter run
   ```

---

## 🔑 Configuração da API do Giphy

1. Crie uma conta gratuita no [Giphy Developers](https://developers.giphy.com/).  
2. Gere uma **API Key**.  
3. Substitua sua chave no endpoint dentro do arquivo `home_page.dart`.

Exemplo:
```dart
final String _apiKey = "SUA_API_KEY_AQUI";
```

---

## 👨‍💻 Autor

Desenvolvido por [**Marcos Aurélio**](https://github.com/marcos-devmob)  
💬 Projeto de estudo e prática com **Flutter** e integração de APIs REST.

---

## 🧾 Licença

Este projeto é de uso livre para fins de estudo e aprendizado.  
Sinta-se à vontade para clonar, testar e contribuir! 🚀

