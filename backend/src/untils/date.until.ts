// Lấy phần "ngày" theo UTC, dùng để đếm/so sánh ngày lịch bo qua gio
export function toCivilDate(date: Date): Date {
  return new Date(
    Date.UTC(date.getUTCFullYear(), date.getUTCMonth(), date.getUTCDate()),
  );
}

//Dem co bao nhieu ngay tinh ca hai dau
export function diffInCivilDays(start: Date, end: Date): number {
  const MS_PER_DAY = 86_400_000;
  const startCivil = toCivilDate(start);
  const endCivil = toCivilDate(end);
  return (
    Math.round((endCivil.getTime() - startCivil.getTime()) / MS_PER_DAY) + 1
  ); // inclusive
}

//Cong them N ngay
export function addCivilDays(date: Date, days: number): Date {
  const result = toCivilDate(date);
  result.setUTCDate(result.getUTCDate() + days);
  return result;
}
