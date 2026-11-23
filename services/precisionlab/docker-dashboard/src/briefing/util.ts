export function formatHour(h: number) {
    return `${h % 12 || 12} ${h >= 12 ? 'PM' : 'AM'}`;
}
