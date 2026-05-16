package com.vida.project

import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.SharedPreferences
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetProvider

class ContraPecadoWidgetProvider : HomeWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        widgetData: SharedPreferences
    ) {
        val phrase = widgetData.getString("phrase", null) ?: ""

        val views = RemoteViews(context.packageName, R.layout.contra_pecado_widget)

        if (phrase.isNotEmpty()) {
            views.setTextViewText(R.id.widget_phrase, "\u201C$phrase\u201D")
            views.setViewVisibility(R.id.widget_label, android.view.View.VISIBLE)
        } else {
            views.setTextViewText(R.id.widget_phrase, "")
            views.setViewVisibility(R.id.widget_label, android.view.View.GONE)
        }

        val background = widgetData.getString("background", null) ?: ""
        if (background.isNotEmpty()) {
            val num = background.replace(Regex("[^0-9]"), "")
            if (num.isNotEmpty()) {
                val resId = context.resources.getIdentifier(
                    "contra_$num", "drawable", context.packageName
                )
                if (resId != 0) {
                    views.setImageViewResource(R.id.widget_background, resId)
                }
            }
        } else {
            views.setImageViewResource(R.id.widget_background, 0)
        }

        for (id in appWidgetIds) {
            appWidgetManager.updateAppWidget(id, views)
        }
    }
}
