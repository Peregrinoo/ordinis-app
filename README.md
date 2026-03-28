<img width="100%" src="https://capsule-render.vercel.app/api?type=waving&color=D8C3A5&height=120&section=header"/>

# Ordinis – Reflexões cristãs diárias para ordenar o amor 🤍

<p align="center">
  <img alt="Flutter" src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white" />
  <img alt="Dart" src="https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white" />
  <img alt="Provider" src="https://img.shields.io/badge/State%20Management-Provider-8E7DBE?style=for-the-badge" />
  <img alt="Platform" src="https://img.shields.io/badge/Platform-Android-lightgrey?style=for-the-badge" />
</p>

<p align="center">
  <img src="assets/readme/splash.png" width="220" alt="Splash screen do Ordinis" />
  <img src="assets/readme/home.png" width="220" alt="Tela principal do Ordinis" />
  <img src="assets/readme/favorites.png" width="220" alt="Tela de favoritos do Ordinis" />
</p>

<p align="center">
  <i>Ordenando o amor, um dia por vez.</i>
</p>

---

## EN

> Daily Christian reflections inspired by Saint Augustine, designed to help the soul return to what truly matters.

### ✨ About

**Ordinis** is a mobile application focused on daily Christian reflections inspired by **Saint Augustine** and the pursuit of a life in communion with **Jesus Christ**.

Its purpose is to provide a daily moment of pause, recollection, and spiritual contemplation through an experience that is both elegant and accessible.

More than a quote app, Ordinis was conceived as a devotional reading experience — one that helps the user revisit essential themes such as truth, interiority, ordered love, and communion with God.

---

### 🎯 Purpose

Ordinis exists to make Christian reflection something:

- beautiful
- simple
- contemplative
- accessible
- meaningful

In a distracted and accelerated world, the app invites the user back to silence, spiritual recollection, and the essential.

---

### 📱 Features

- Daily reflection experience
- Modern interpretation layer for each excerpt
- Favorites system
- Reflection sharing
- Local content loading from JSON
- Offline-first usage
- Elegant reading-focused interface
- Expandable structure for future devotional features

---

### 🧱 Tech Stack

- **Framework:** Flutter
- **Language:** Dart
- **State Management:** Provider
- **Local Data Source:** JSON assets
- **Persistence:** SharedPreferences
- **Typography:** Google Fonts
- **Architecture:** Feature-oriented and modular

---

### 📦 Main Packages

- `provider`
- `google_fonts`
- `shared_preferences`
- Flutter native navigation
- Local JSON parsing
- Custom reusable widgets

---

### 🎨 Design

The visual identity of Ordinis was designed to communicate:

- serenity
- contemplation
- sobriety
- warmth
- beauty

Soft tones, classical typography, generous spacing, and immersive imagery help transform reading into a quiet spiritual experience.

---

### 📸 Screenshots

<p align="center">
  <img src="assets/readme/splash.png" width="220" alt="Splash screen" />
  <img src="assets/readme/home.png" width="220" alt="Home screen" />
  <img src="assets/readme/favorites.png" width="220" alt="Favorites screen" />
</p>

---

## PT-BR

> Reflexões cristãs diárias inspiradas em Santo Agostinho, pensadas para ajudar a alma a voltar ao essencial.

### ✨ Sobre

**Ordinis** é um aplicativo mobile de reflexões cristãs diárias inspirado em **Santo Agostinho** e na busca de uma vida em comunhão com **Jesus Cristo**.

Seu propósito é oferecer diariamente um momento de pausa, recolhimento e contemplação espiritual por meio de uma experiência bela, simples e acessível.

Mais do que um app de frases, o Ordinis foi concebido como uma experiência devocional de leitura — algo que ajuda o usuário a revisitar temas essenciais como verdade, interioridade, amor ordenado e comunhão com Deus.

---

### 🎯 Propósito

O Ordinis existe para tornar a reflexão cristã algo:

- belo
- simples
- contemplativo
- acessível
- significativo

Em um mundo acelerado e disperso, o aplicativo convida o usuário a retornar ao silêncio, ao recolhimento espiritual e ao essencial.

---

### 📱 Funcionalidades

- Experiência de reflexão diária
- Camada de interpretação moderna para cada trecho
- Sistema de favoritos
- Compartilhamento de reflexões
- Carregamento local de conteúdo em JSON
- Uso offline-first
- Interface elegante com foco em leitura
- Estrutura preparada para expansão futura

---

### 🧱 Stack Técnica

- **Framework:** Flutter
- **Linguagem:** Dart
- **Gerenciamento de Estado:** Provider
- **Fonte de Dados Local:** JSON em assets
- **Persistência:** SharedPreferences
- **Tipografia:** Google Fonts
- **Arquitetura:** Modular e orientada a features

---

### 📦 Principais Pacotes

- `provider`
- `google_fonts`
- `shared_preferences`
- Navegação nativa do Flutter
- Leitura e parsing de JSON local
- Widgets reutilizáveis customizados

---

### 🎨 Design

A identidade visual do Ordinis foi pensada para transmitir:

- serenidade
- contemplação
- sobriedade
- calor
- beleza

Tons suaves, tipografia clássica, bom respiro visual e imagens imersivas ajudam a transformar a leitura em uma experiência espiritual mais silenciosa e profunda.

---

### 📸 Imagens do App

<p align="center">
  <img src="assets/readme/splash.png" width="220" alt="Tela de abertura do Ordinis" />
  <img src="assets/readme/home.png" width="220" alt="Tela principal do Ordinis" />
  <img src="assets/readme/favorites.png" width="220" alt="Tela de favoritos do Ordinis" />
</p>

---

### 🗂️ Estrutura do Projeto

```bash
lib/
├── core/                 # Constantes, tema, utilitários
├── data/
│   ├── models/           # Modelos da aplicação
│   ├── repositories/     # Camada de acesso aos dados
│   └── services/         # Leitura de JSON, persistência local, etc.
├── providers/            # Gerenciamento de estado com Provider
├── screens/              # Telas da aplicação
├── widgets/              # Componentes reutilizáveis
└── main.dart             # Ponto de entrada
