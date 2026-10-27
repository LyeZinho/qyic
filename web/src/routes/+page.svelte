<script lang="ts">
	const features = [
		{
			icon: '🎮',
			title: 'Gamified quizzes',
			description: 'Multiple choice, fill-in-the-blank, matching, and true/false.'
		},
		{
			icon: '🧠',
			title: 'Spaced repetition',
			description: 'FSRS-based scheduling decides when each card comes back.'
		},
		{
			icon: '⚡',
			title: 'Offline-first',
			description: 'Study anywhere — sync happens quietly in the background.'
		},
		{
			icon: '📦',
			title: 'Shareable decks',
			description: 'One .qdeck file, shared directly between people.'
		}
	];
</script>

<svelte:head>
	<title>Qyic</title>
	<meta name="description" content="Qyic — spaced repetition that plays like a game." />
</svelte:head>

<main>
	<header>
		<h1>Qyic</h1>
		<p class="tagline">Spaced repetition that plays like a game.</p>
		<p class="status">
			Web client scaffold — the study loop lands in milestone M1 (<a
				href="https://github.com/LyeZinho/qyic/blob/main/docs/PLAN.md">plan</a
			>).
		</p>
	</header>

	<section aria-label="Features">
		{#each features as feature (feature.title)}
			<article>
				<span class="icon" aria-hidden="true">{feature.icon}</span>
				<h2>{feature.title}</h2>
				<p>{feature.description}</p>
			</article>
		{/each}
	</section>
</main>

<style>
	:global(body) {
		margin: 0;
		background: #0f1117;
		color: #e7e9ee;
		font-family:
			system-ui,
			-apple-system,
			'Segoe UI',
			Roboto,
			sans-serif;
	}

	main {
		max-width: 60rem;
		margin: 0 auto;
		padding: 4rem 1.5rem;
	}

	header {
		text-align: center;
		margin-bottom: 3rem;
	}

	h1 {
		font-size: 3.5rem;
		margin: 0;
		letter-spacing: -0.03em;
	}

	.tagline {
		font-size: 1.25rem;
		color: #a5adbd;
	}

	.status {
		font-size: 0.95rem;
		color: #7c8496;
	}

	a {
		color: #8b9dff;
	}

	section {
		display: grid;
		grid-template-columns: repeat(auto-fit, minmax(14rem, 1fr));
		gap: 1rem;
	}

	article {
		background: #171a23;
		border: 1px solid #232735;
		border-radius: 0.75rem;
		padding: 1.25rem;
	}

	.icon {
		font-size: 1.75rem;
	}

	h2 {
		font-size: 1.05rem;
		margin: 0.5rem 0 0.25rem;
	}

	p {
		margin: 0;
		color: #a5adbd;
		font-size: 0.95rem;
	}
</style>
