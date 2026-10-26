# 🎯 Ganki (Game + Anki)

> **Ganki** é um aplicativo de aprendizagem e memorização que une o poder do **Algoritmo de Repetição Espaçada (SRS)** à interatividade e ao engajamento dos **quizzes gamificados**.

---

## 📌 Sobre o Projeto

O Anki revolucionou a retenção de conhecimento a longo prazo, mas a experiência clássica de flashcards passivos pode se tornar monótona. O **Ganki** resolve essa dor transformando a revisão de conteúdos em um jogo dinâmico com múltiplos formatos de quiz, mantendo a eficiência científica da repetição espaçada por baixo dos panos.

### ✨ Principais Funcionalidades

* 🎮 **Modos de Quiz Dinâmicos:** Múltipla escolha, preenchimento de lacunas, associação e verdadeiro/falso.
* ⚡ **Offline-First:** Estude em qualquer lugar, mesmo sem conexão com a internet.
* 🧠 **Algoritmo Moderno de SRS:** Implementação otimizada do algoritmo FSRS para agendar as revisões de forma inteligente.
* 🏆 **Elementos de Gamificação:** Sistema de XP, níveis, ofensivas (*streaks*) e conquistas.
* 🔄 **Sincronização Multiplataforma:** Acompanhe seu progresso sincronizado entre dispositivos móveis e a web.

---

## 🛠️ Tech Stack

Opções de engenharia focadas em **performance nativa**, **baixo consumo de recursos** e **experiência fluida**:

| Camada | Tecnologia | Descrição / Motivação |
| :--- | :--- | :--- |
| **Mobile** | **Flutter** + **SQLite** | Performance de até 120 FPS sem *bridges* de JS e suporte offline completo via banco local. |
| **Frontend Web** | **SvelteKit** + **TypeScript** | Compilação para JS imperativo super leve, sem Virtual DOM e carregamento instantâneo. |
| **Backend API** | **Rust** + **PostgreSQL** | Segurança de memória, concorrência extrema e baixíssimo uso de CPU/RAM no servidor. |
| **DevOps** | **Docker** + **Docker Compose** | Containerização consistente para ambiente de desenvolvimento e produção. |

---

## 🏗️ Arquitetura do Sistema

```text
       ┌────────────────┐         ┌────────────────┐
       │ Mobile App     │         │ Web App        │
       │ (Flutter/SQLite)│         │ (SvelteKit)    │
       └───────┬────────┘         └───────┬────────┘
               │                          │
               │        REST / gRPC       │
               └────────────┐─────────────┘
                            ▼
                   ┌─────────────────┐
                   │  Backend (Rust) │
                   └────────┬────────┘
                            ▼
                   ┌─────────────────┐
                   │   PostgreSQL    │
                   └─────────────────┘

```

---

## 🚀 Como Executar o Projeto Localmente

### Pré-requisitos

Certifique-se de ter instalado em sua máquina:

* [Git](https://git-scm.com/)
* [Docker](https://www.docker.com/) e Docker Compose
* [Flutter SDK](https://docs.flutter.dev/get-started/install) (para o ambiente mobile)
* [Node.js](https://nodejs.org/) (para a interface web em SvelteKit)
* [Rust & Cargo](https://www.rust-lang.org/tools/install) (para desenvolvimento direto no backend)

---

### 1. Clonar o Repositório

```bash
git clone [https://github.com/seu-usuario/ganki.git](https://github.com/seu-usuario/ganki.git)
cd ganki

```

### 2. Iniciar o Backend & Banco de Dados (via Docker)

```bash
# Inicia o PostgreSQL e o servidor Rust
docker-compose up -d

```

O servidor da API estará rodando em `http://localhost:8080` (ou na porta configurada no `.env`).

---

### 3. Rodar a Aplicação Web (SvelteKit)

```bash
cd web
npm install
npm run dev

```

Acesse no navegador: `http://localhost:5173`

---

### 4. Rodar o Aplicativo Mobile (Flutter)

```bash
cd mobile
flutter pub get
flutter run

```

---

## 📂 Estrutura do Repositório

```text
ganki/
├── server/       # API Backend em Rust (Actix-web / Axum + Diesel / SQLx)
├── mobile/       # Aplicativo Mobile em Flutter (Dart + SQLite)
├── web/          # Aplicação Web em SvelteKit + TypeScript
├── docker-compose.yml
└── README.md

```
