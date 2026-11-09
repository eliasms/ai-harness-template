---
name: angular-ui-patterns
description: Fornece diretrizes e antipadrões de arquitetura de UI para Angular 17+, focando em composição de componentes, performance OnPush, Signals e acessibilidade via Angular CDK. Use ao criar ou refatorar componentes Angular.
---

# Angular UI/UX Composition & Performance Patterns

## 1. Evite o antipadrão de Props Booleanas
- Antipadrão: `<app-card [isHeaderCompact]="true" [showFooter]="false" [hasBadge]="true">`
- Padrão recomendado: Projeção de conteúdo com slots nomeados:
  ```html
  <app-card>
    <app-card-header ngProjectAs="[card-header]">Título</app-card-header>
    <p>Conteúdo principal</p>
    <app-card-actions ngProjectAs="[card-actions]">
      <button mat-button>Ação</button>
    </app-card-actions>
  </app-card>
  ```

## 2. Reatividade de Template com Signals
- Evite invocar métodos diretamente no template (ex: `{{ calculateLayout() }}`).
- Use `computed()` para valores derivados da UI:
  ```typescript
  readonly isExpanded = signal(false);
  readonly panelClass = computed(() => this.isExpanded() ? 'panel-open' : 'panel-closed');
  ```

## 3. Performance de Carregamento com Deferrable Views
- Utilize o bloco `@defer` para adiar a renderização de componentes secundários (modais, menus, gráficos analíticos):
  ```html
  @defer (on viewport) {
    <app-heavy-chart [data]="analyticsData()" />
  } @placeholder {
    <div class="chart-skeleton" aria-hidden="true"></div>
  }
  ```

## 4. Gerenciamento de Foco e Acessibilidade (Angular CDK)
- Para menus, drawers e modais interativos, utilize `cdkTrapFocus` e utilitários de teclado:
  ```html
  <div cdkTrapFocus [cdkTrapFocusAutoCapture]="true" role="dialog" aria-modal="true">
    ...
  </div>
  ```
