import {
  PLACE_CATEGORY,
  TRIP_MISSION_VERIFY,
} from '../../../../generated/prisma/enums';
import { MAX_MISSIONS_PER_TRIP } from './trip-mission.constants';
import { resolveCheckinTargetCount } from './trip-mission-verify';

export type SeedTemplate = {
  id: string;
  code: string;
  group: string;
  title: string;
  subtitle: string;
  icon: string;
  verifyType: TRIP_MISSION_VERIFY | string;
  verifyPayload: unknown;
  pointsReward: number;
  targetCountDefault: number;
  scope: string;
  sortOrder: number;
  seedRules: Array<{
    placeCategories: PLACE_CATEGORY[] | string[];
    requireNewCity: boolean;
    priority: number;
  }>;
};

export type SeedContext = {
  itineraryPlaceCount: number;
  itineraryCategories: ReadonlySet<string>;
  itineraryCities: ReadonlySet<string>;
  /** Normalized lowercase cities the user has visited before. */
  historicalCities: ReadonlySet<string>;
};

export type SeededMissionPlan = {
  templateId: string;
  code: string;
  group: string;
  title: string;
  subtitle: string;
  icon: string;
  verifyType: string;
  verifyPayload: unknown;
  targetCount: number;
  pointsReward: number;
  scope: string;
  sortOrder: number;
  priority: number;
};

function normalizeCity(city: string): string {
  return city.trim().toLowerCase();
}

function isEligible(
  template: SeedTemplate,
  ctx: SeedContext,
): { ok: boolean; priority: number } {
  const rule = template.seedRules[0];
  if (!rule) {
    return { ok: true, priority: template.sortOrder };
  }

  if (rule.requireNewCity) {
    const hasNewCity = [...ctx.itineraryCities].some(
      (city) => !ctx.historicalCities.has(normalizeCity(city)),
    );
    if (!hasNewCity) {
      return { ok: false, priority: rule.priority };
    }
  }

  if (rule.placeCategories.length > 0) {
    const needed = rule.placeCategories.map((c) => String(c).toUpperCase());
    const hit = needed.some((cat) => ctx.itineraryCategories.has(cat));
    if (!hit) {
      return { ok: false, priority: rule.priority };
    }
  }

  return { ok: true, priority: rule.priority };
}

/** Pure selection of up to MAX_MISSIONS_PER_TRIP templates for a trip. */
export function planTripMissions(
  templates: SeedTemplate[],
  ctx: SeedContext,
): SeededMissionPlan[] {
  const eligible: SeededMissionPlan[] = [];

  for (const template of templates) {
    const { ok, priority } = isEligible(template, ctx);
    if (!ok) {
      continue;
    }

    const targetCount =
      template.verifyType === TRIP_MISSION_VERIFY.CHECKIN_COUNT ||
      template.verifyType === 'CHECKIN_COUNT'
        ? resolveCheckinTargetCount(
            template.targetCountDefault,
            ctx.itineraryPlaceCount,
          )
        : Math.max(1, template.targetCountDefault);

    eligible.push({
      templateId: template.id,
      code: template.code,
      group: template.group,
      title: template.title,
      subtitle: template.subtitle,
      icon: template.icon,
      verifyType: String(template.verifyType),
      verifyPayload: template.verifyPayload ?? {},
      targetCount,
      pointsReward: template.pointsReward,
      scope: template.scope,
      sortOrder: template.sortOrder,
      priority,
    });
  }

  eligible.sort((a, b) => a.priority - b.priority || a.sortOrder - b.sortOrder);
  return eligible.slice(0, MAX_MISSIONS_PER_TRIP);
}
