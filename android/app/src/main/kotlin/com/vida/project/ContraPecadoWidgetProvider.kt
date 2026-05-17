package com.vida.project

import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.SharedPreferences
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetProvider
import java.util.Calendar

class ContraPecadoWidgetProvider : HomeWidgetProvider() {
    private val phrases = listOf(
        "Dios sigue trabajando en ti",
        "La gracia es más grande que tu pecado",
        "Respira, ora y sigue",
        "Mantente firme en tu posición",
        "Tu identidad está en Cristo",
        "Lo eterno, antes que el placer",
        "Tu lucha tiene un propósito"
    )

    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        widgetData: SharedPreferences
    ) {
        val isEnabled = widgetData.getBoolean("contra_pecado", false)

        val views = RemoteViews(context.packageName, R.layout.contra_pecado_widget)

        if (isEnabled) {
            val calendar = Calendar.getInstance()
            val dayOfWeek = calendar.get(Calendar.DAY_OF_WEEK)
            val index = (dayOfWeek + 5) % 7

            views.setTextViewText(R.id.widget_phrase, "\u201C${phrases[index]}\u201D")
            views.setViewVisibility(R.id.widget_label, android.view.View.VISIBLE)

            val bgResId = context.resources.getIdentifier(
                "contra_${index + 1}", "drawable", context.packageName
            )
            if (bgResId != 0) {
                views.setImageViewResource(R.id.widget_background, bgResId)
            }
        } else {
            views.setTextViewText(R.id.widget_phrase, "")
            views.setViewVisibility(R.id.widget_label, android.view.View.GONE)
            views.setImageViewResource(R.id.widget_background, 0)
        }

        for (id in appWidgetIds) {
            appWidgetManager.updateAppWidget(id, views)
        }
    }
}
