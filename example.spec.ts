import test from "@playwright/test";

test('works', async ({ page }) => {
    await page.goto('https://example.com');
});
