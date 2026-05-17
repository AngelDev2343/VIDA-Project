package com.vida.project

import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.SharedPreferences
import android.util.TypedValue
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetProvider

class FavoritoWidgetProvider : HomeWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        widgetData: SharedPreferences
    ) {
        val isEnabled = widgetData.getBoolean("favorito", false)
        val ref = widgetData.getString("fav_ref", null) ?: ""
        val verse = widgetData.getString("fav_verse", null) ?: ""

        val views = RemoteViews(context.packageName, R.layout.favorito_widget)

        if (isEnabled && verse.isNotEmpty()) {
            views.setImageViewResource(R.id.widget_background, R.drawable.widget_fav)
            views.setTextViewText(R.id.widget_verse, "\u201C$verse\u201D")
            if (verse.length > 80) {
                views.setTextViewTextSize(R.id.widget_verse, TypedValue.COMPLEX_UNIT_SP, 12f)
            }
            views.setTextViewText(R.id.widget_ref, ref)
        } else {
            views.setImageViewResource(R.id.widget_background, 0)
            views.setTextViewText(R.id.widget_verse, "")
            views.setTextViewText(R.id.widget_ref, "")
        }

        for (id in appWidgetIds) {
            appWidgetManager.updateAppWidget(id, views)
        }
    }
}
